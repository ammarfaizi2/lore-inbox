Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVAODcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVAODcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 22:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVAODcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 22:32:25 -0500
Received: from terrhq.ru ([81.222.97.18]:49089 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S262196AbVAODcW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 22:32:22 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Nick <nick@galaktika.ru>
Subject: Re: Can I ask a smbfs question here?
Date: Sat, 15 Jan 2005 06:31:58 +0300
User-Agent: KMail/1.7.1
References: <41E87CB1.30804@galaktika.ru>
In-Reply-To: <41E87CB1.30804@galaktika.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501150631.59243.yarick@it-territory.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !
On 15 January 2005 05:15, you wrote:
>

> To make the share user mountable I changed the owner of the mountpoint
> to the regular user I am using, chmodded one of the binaries (sorry - do
/usr/sbin/smbmnt ?
> not remember which one - found its name in one of FAQs) and specified
....
>username=administrator,password=xxx,fmask=0666,codepage=cp866,iocharset=utf8,users 
Are you sure it's "users" and not "user" ?
>
> Any ideas if it is possible to fix this? I can "sudo mount" all the time
> but it does not sound right...
And what's wrong with smbmount ?
smbmount //server/share /your/mountpoint -o 
username=<uname>,iocharset=utf8,codepage=cp866
Works like a charm as long as /usr/sbin/smbmnt is suid-root

-- 
Managing your Territory since the dawn of times ...
