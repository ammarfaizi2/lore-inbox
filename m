Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030391AbWBARlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030391AbWBARlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbWBARll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:41:41 -0500
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:32284 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1030391AbWBARll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:41:41 -0500
Message-ID: <BAYC1-PASMTP05E6111897E4EEAB87C04FAE0B0@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Wed, 1 Feb 2006 12:41:51 -0500
From: sean <seanlkml@sympatico.ca>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: bernd@firmix.at, xslaby@fi.muni.cz, wellspringkavitha@yahoo.co.in,
       linux-kernel@vger.kernel.org
Subject: Re: root=LABEL= problem [Was: Re: Linux Issue]
Message-Id: <20060201124151.5b4c0435.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.61.0602011718450.22529@yvahk01.tjqt.qr>
References: <20060201114845.E41F222AF24@anxur.fi.muni.cz>
	<Pine.LNX.4.61.0602011713410.22529@yvahk01.tjqt.qr>
	<1138810616.16643.30.camel@tara.firmix.at>
	<Pine.LNX.4.61.0602011718450.22529@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Feb 2006 17:41:40.0704 (UTC) FILETIME=[C24B8E00:01C62756]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2006 17:18:56 +0100 (MET)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> >Yes, in RedHat's/Fedora's kernels since ages.

Label processing in Red Hat/Fedora distributions is not handled in the
kernel at all (thus you won't find a patch).   It's all done in user space
via the initrd and works with vanilla kernels without a problem.

Sean
