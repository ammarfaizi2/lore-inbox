Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263037AbTDFRPu (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 13:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263038AbTDFRPu (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 13:15:50 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63118
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263037AbTDFRPt (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 13:15:49 -0400
Subject: Re: Kernel support for 24-bit sound
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pigeon <jah.pigeon@ukonline.co.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406162301.GA1364@pigeon.pigeonloft>
References: <20030406162301.GA1364@pigeon.pigeonloft>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049646540.1349.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 17:29:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 17:23, Pigeon wrote:
> I am trying to add support for the 24-bit S/PDIF input mode of my
> CMI8738 sound card to the cmpci.c driver of kernel 2.4.20.

2.4.21pre -ac and I think now base trees have 24bit support in the
core code included and support for 24bit USB devices added. OSS 
doesn't really think happily in 24bit mode and the apps don't know
about it either. The ALSA layer in 2.5.x is a rather nicer replacement
without a lot of the limitations

