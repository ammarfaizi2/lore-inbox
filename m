Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbWHWTnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbWHWTnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbWHWTnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:43:17 -0400
Received: from main.gmane.org ([80.91.229.2]:11934 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965082AbWHWTnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:43:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@TU-Ilmenau.DE>
Subject: Re: Hardware vs. Software Raid Speed
Date: Wed, 23 Aug 2006 21:42:10 +0200
Organization: Technische Universitaet Ilmenau, Germany
Message-ID: <ecib2i$1ip$2@sea.gmane.org>
References: <44EBFB3E.8070905@perkel.com> <44EC02FD.7050207@tomt.net> <44EC94A9.4010903@gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54b8ab55.dip0.t-ipconnect.de
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo <htejun@gmail.com> wrote:
> And, yeah, they're all software RAID.  Also, there isn't much to be 
> gained from making RAID0/1 hardware.  The software overhead isn't that 

The CPU cycles in fact don't usually matter. The I/O overhead (on the
PCI bus) due to multiple transfers of the (more or less) same data is
typically more interesting.


regards
   Mario
-- 
The secret that the NSA could read the Iranian secrets was more
important than any specific Iranian secrets that the NSA could
read.                           -- Bruce Schneier

