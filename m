Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTHVEz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 00:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbTHVEz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 00:55:58 -0400
Received: from [202.107.117.26] ([202.107.117.26]:35549 "EHLO ldap")
	by vger.kernel.org with ESMTP id S263019AbTHVEz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 00:55:56 -0400
Date: Fri, 22 Aug 2003 12:55:48 +0800
From: "Bill J.Xu" <xujz@neusoft.com>
Subject: Re: "ctrl+c" disabled!
To: Charles Lepple <clepple@ghz.cc>, linux-kernel@vger.kernel.org
Message-id: <05a501c36869$a7aeee60$2a01010a@avwindows>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-Mailer: Microsoft Outlook Express 6.00.3790.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
References: <036601c367e0$01adabc0$2a01010a@avwindows>
 <3F457A19.8E8A1F65@gmx.de> <04b901c36852$dccc7660$2a01010a@avwindows>
 <3F45830A.5C0F5BCA@gmx.de> <053301c3685c$9ea6fe50$2a01010a@avwindows>
 <bi45b6$kor$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah,that is the result after pressing ctrl+c, ctrl+d. maybe od do not get the "ctrl+c" signal.
But I use SecureCRT with the same configration at the same PC to telnet the linux box,everything is OK.
So I think that if there is some thing wrong with linux kernel?

Bill

----- Original Message ----- 
From: "Charles Lepple" <clepple@ghz.cc>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, August 22, 2003 12:14 PM
Subject: Re: "ctrl+c" disabled!


> Bill J.Xu wrote:
> > after run od -tx1, the following is the result
> > ------------------------------------------------
> > bash-2.05# ./od -tx1
> > 0000000
> 
> That's after you pressed ^C in your terminal program? What you have 
> there shows that od has not received any characters.
> 
> Pick another control character, and use 'stty intr' to set that as your 
> interrupt character. I don't have any experience with SecureCRT, but it 
> may use ^C to implement the Windows Edit->Copy function.
> 
> -- 
> Charles Lepple <ghz.cc!clepple>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
