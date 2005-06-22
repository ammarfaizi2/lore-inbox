Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVFVBEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVFVBEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 21:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbVFVBEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 21:04:47 -0400
Received: from web32409.mail.mud.yahoo.com ([68.142.207.202]:8544 "HELO
	web32409.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262431AbVFVBEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 21:04:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Cm+wBMoZYMvh5priUnzv1bmpld9709S4/iOyTU0ltSp3DO34tdxHqWZiHww+jKe+InlYmzktiWi34E7Kw8t5FSbLtg/xA/vn40b7ECwtwTO7yFKJCtDuLD7ctUrfk9GAOhBI9cW8Tc2Z/7flJ2WnZHXjCpC7U5gz8ASngbnbXEA=  ;
Message-ID: <20050622010432.49221.qmail@web32409.mail.mud.yahoo.com>
Date: Tue, 21 Jun 2005 18:04:32 -0700 (PDT)
From: Anil kumar <anils_r@yahoo.com>
Subject: "no version for struct_module: found" error
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am loading an non-gpl module. I am getting error:
"no version for struct_module found":tainted kernel.

Its for > 2.6.8 kernels.

I know that I get tainted kernel error when its not
GPL, but what does the error "no version for
struct_module found" mean?
How to get rid of this?
I checked the module.c under kernel dir, I guess I am
getting this error for 
if(!(tainted & TAINTED_FORCED_MODULE)...


with regards,
   Anil


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
