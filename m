Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUHOWQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUHOWQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267185AbUHOWQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:16:58 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:22961 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S267182AbUHOWQu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:16:50 -0400
Message-ID: <411FE14D.2080400@blue-labs.org>
Date: Sun, 15 Aug 2004 18:18:53 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a3) Gecko/20040815
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <1092603321.18410.5.camel@localhost.localdomain> <411FDEA9.2010802@pobox.com>
In-Reply-To: <411FDEA9.2010802@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------040806050207070505060506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040806050207070505060506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[...]

> Yep, it's more like ethtool(8) or cvs(1) in its syntax.  There is big 
> difference in usability (for me anyway) between "command [options]..." 
> and an unordered list of --args.  Especially as the list of commands 
> grows longer.  It provides more structure.
>
> Each command can have options, --foo-bar=baz if you like, I suppose.


I would rather see --option=xyz than option xyz.  End users are going to 
be using it in scripts and in the event a parameter becomes "", then it 
will become --option1= --option2=def instead of option1 option2 def.  I 
would find it easier to parse, --option= is easy to ignore, option 
option has to be recognized as an empty option instead of using option 
as the first option's argument.

Just my opinion,
-david


--------------040806050207070505060506
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------040806050207070505060506--
