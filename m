Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265064AbUFAOTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265064AbUFAOTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 10:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUFAOTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 10:19:39 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:12774 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S265079AbUFAOTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 10:19:32 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-22.tower-45.messagelabs.com!1086099570!3193739
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: makefile fix
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Tue, 1 Jun 2004 10:19:03 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F760624337C@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: makefile fix
Thread-Index: AcRGnk6hPWCyDssiR/SDfzR9NUDnPgBRPhmg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Paul Jackson" <pj@sgi.com>, "carbonated beverage" <ramune@net-ronin.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick FYI:

Bash supports C-style if() statements using double parenthesis.

$ if (( 5 > 3 )); then
> echo hi
> fi
Hi


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paul Jackson
Sent: Sunday, May 30, 2004 7:39 PM
To: carbonated beverage
Cc: linux-kernel@vger.kernel.org
Subject: Re: makefile fix

The (( x > y )) syntax looks like ksh stuff,
equivalent to the more widely supported [ x -gt y ].

Your patch looks reasonable to me.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


