Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278550AbRJSRDm>; Fri, 19 Oct 2001 13:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278548AbRJSRDe>; Fri, 19 Oct 2001 13:03:34 -0400
Received: from mail3.panix.com ([166.84.0.167]:15817 "HELO mail3.panix.com")
	by vger.kernel.org with SMTP id <S278546AbRJSRDW>;
	Fri, 19 Oct 2001 13:03:22 -0400
From: "Roy Murphy" <murphy@panix.com>
Reply-To: murphy@panix.com
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Oct 2001 13:03:56 -0500
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
X-Mailer: DMailWeb Web to Mail Gateway 2.6k, http://netwinsite.com/top_mail.htm
Message-id: <3bd05cfc.6bb9.0@panix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'Twas brillig when Taral scrobe:
>You're quite right. Module insertion is linking. And distributing a 
>kernel with binary-only modules already inserted would be a GPL 
>violation. What modules do is let people do the link at the last stage 
>-- the end user. The GPL does not restrict what end-users do with your 
>code if it doesn't involve redistribution. 

The point was made earlier that a module might include some code expanded from
a macro in a kernel header file.  Producers of binary 
modules could adopt a "clean room" approach (as the first cloners of 
the IBM PC BIOS did) and have one group write a technical specification 
for any necessary kernel headers and have a second group implement 
substitute headers from the specification.

>I also think this is somewhat ridiculous. If I (the binary module 
>maker) distribute a program which effectively replicates the 
>functionality of insmod without the licence checking, and distribute 
>that program with my module, am I violating any restrictions? I don't 
>think so, since it's the end-user that ends up linking the kernel to 
>the module. No linked products are actually distributed... 

In the US it may be a violation of the DCMA prohibition on 
circumvention of "effective access controls" (and perhaps violations of 
corresponding laws in some European countries).  Though that's a whole 
'nother huge legal morass.
 
