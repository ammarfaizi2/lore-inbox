Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVKWQ4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVKWQ4L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVKWQ4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:56:11 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:36841 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932094AbVKWQ4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:56:09 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17284.40630.135499.33136@gargle.gargle.HOWL>
Date: Wed, 23 Nov 2005 19:54:14 +0300
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
In-Reply-To: <20051123164215.12647.qmail@web25813.mail.ukl.yahoo.com>
References: <17284.38866.189529.510004@gargle.gargle.HOWL>
	<20051123164215.12647.qmail@web25813.mail.ukl.yahoo.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis writes:
 > 

[...]

 > int foo(void)
 > {
 >         int tmp;
 > 
 >         tmp = bar();
 >         [...]
 >         return tmp;
 > }
 > 
 > How do you know if tmp store an errno value ? You have to look into bar and  so

Of course you should. How to debug anything without knowing what called
function is doing? This is kernel programming after all. Which, by the
way, means that debugging convenience is not at all important.

 > on...By using "enum errnoval", gdb can directly tell you that a variable stores
 > an errno value.
 > 
 > Thanks

Nikita.
