Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUIWP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUIWP0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUIWP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:26:38 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:13723
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S266296AbUIWP0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:26:36 -0400
Message-ID: <4152EB1C.5020406@ppp0.net>
Date: Thu, 23 Sep 2004 17:26:20 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: linux1394-devel@lists.sourceforge.net, bcollins@debian.org
Subject: Re: Oops in dv1394_remove_host (inkl. fix)
References: <4152E890.5030500@ppp0.net>
In-Reply-To: <4152E890.5030500@ppp0.net>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Dittmer wrote:
> I was playing around with dummyphp. When removing the pci device
> of ohci1394 I got an oops due to the missing initialization
> of the .name attribute of the dummy driver (I think).

Indeed, I just tested it and it really fixes the issue :-)

Jan
