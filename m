Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWGCVZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWGCVZz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWGCVZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:25:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:50001 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932132AbWGCVZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:25:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=P2vOpB+fVZ/KeFrRCGGFCYk8vOYf7bKBmK1n8pKArpsnYldVlppjiCIG0K0ByJtzx1hTTvBJ+I/KwQI6ksy1pUKaOR01gSmTf8P7np+sN55JXTzG8+2VcfUSzM1sy2Ov7i1xakFTAYOkku0AzjJzInbBNOz5t4OhF9S/pDwD440=
Date: Mon, 3 Jul 2006 23:25:47 +0200
From: Diego Calleja <diegocg@gmail.com>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: arjan@infradead.org, zdzichu@irc.pl, helgehaf@aitel.hist.no,
       sithglan@stud.uni-erlangen.de, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: ext4 features
Message-Id: <20060703232547.2d54ab9b.diegocg@gmail.com>
In-Reply-To: <44A9904F.7060207@wolfmountaingroup.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	<20060701170729.GB8763@irc.pl>
	<20060701174716.GC24570@cip.informatik.uni-erlangen.de>
	<20060701181702.GC8763@irc.pl>
	<20060703202219.GA9707@aitel.hist.no>
	<20060703205523.GA17122@irc.pl>
	<1151960503.3108.55.camel@laptopd505.fenrus.org>
	<44A9904F.7060207@wolfmountaingroup.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Mon, 03 Jul 2006 15:46:55 -0600,
"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com> escribió:

> Add a salvagable file system to ext4, i.e. when a file is deleted, you 
> just rename it and move it to a directory called DELETED.SAV and recycle 
> the files as people allocate new ones.  Easy to do (internal "mv" of 


Easily doable in userspace, why bother with kernel programming
