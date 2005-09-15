Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030400AbVIOFOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbVIOFOW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 01:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbVIOFOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 01:14:22 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62086 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1030392AbVIOFOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 01:14:20 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: [PATCH] Move GFP_KERNEL use out of line to shrink text
Date: Thu, 15 Sep 2005 08:13:23 +0300
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.63.0509131116280.3479@excalibur.intercode> <20050913223511.141e78c1.akpm@osdl.org> <52fys7ze6x.fsf_-_@cisco.com>
In-Reply-To: <52fys7ze6x.fsf_-_@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509150813.24041.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 21:39, Roland Dreier wrote:
>        text    data     bss     dec     hex filename
>     24202272 7609162 1998512 33809946 203e61a vmlinux-before
>     24197561 7609474 1998512 33805547 203d4eb vmlinux-after
> 
> for a net savings of 4711 bytes of text (at a cost of 312 bytes of
> data for some reason).  With my usual config, the patched kernel boots
> and runs fine.

FYI: "some reason" == KALLSYMS
--
vda
