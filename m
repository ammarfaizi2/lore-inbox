Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262740AbTKYPkI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 10:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbTKYPkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 10:40:07 -0500
Received: from cs.columbia.edu ([128.59.16.20]:8639 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S262740AbTKYPkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 10:40:04 -0500
Message-Id: <200311251540.hAPFe2OW014559@sutton.cs.columbia.edu>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Raj <raju@mailandnews.com>
Subject: Re: Replacing tcp_v4_rcv from a module 
Cc: linux-kernel@vger.kernel.org
Reply-To: "Gong Su" <gongsu@cs.columbia.edu>
X-face: (/hxHkDG"rCsP.`[Mfw5_+#\w[r2Tj4j7nds/Fyg8Op'2V!'f.yPTKv+<wHpyoEQ6m^PcfC
 O[m-7]U9)F3Uc5F}&\~f1/zpu`7[VkCL=OX%7At0HOfnZ^p.vzLd"\!m&Z7IT?MnE7i&z+oev.Va~n
 d(whEn#~%D9p8eIvyuP@|!jM5`8lMA-te\"#a%4t_$LFy#%zJkX'THo]l<`dVuNtI%nD{k'_xU0(d+
 z\u{<nnm#jsxB.{
In-reply-to: Your message of "Tue, 25 Nov 2003 14:59:18 +0530."
             <3FC320EE.7010700@mailandnews.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Nov 2003 10:40:02 -0500
From: Gong Su <gongsu@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Raj. Sorry I forgot to say that I'm doing this on 2.4. Is this a 2.5
function? I can't find it in the 2.4 source tree.

-- 
/Gong


Thus did Raj <raju@mailandnews.com> write:
*>Gong Su wrote:
*>
*>>I need some customized function inside tcp_v4_rcv so I wrote a module to
*>>replace tcp_protocol->handler with my own function pointer; and currently
*>>  
*>>
*>Try calling synchronize_net() after your modification and see if it helps.
*>
*>/Raj
*>


