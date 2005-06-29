Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVF2PjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVF2PjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVF2PjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:39:08 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:60515 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261405AbVF2PhQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:37:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cvWEqxB0G2gL/FZ7fjBVKX8hrP4H3n7TbxGOa3Bb6hwtJ11GgK6krOO2AQtnTyc5JuWZrhLWmvNL4KMjgF3UzOzzNeWUj0d9pQqrSxaZCd4eNySQ8ooBQRoRzn7IUrBcfkx4pP0DpwUXAe81mcUW7Wi1s2x1qLUBH+feBwzGjXo=
Message-ID: <94e67edf050629083745bb4183@mail.gmail.com>
Date: Wed, 29 Jun 2005 11:37:14 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: **** How to lock memory pages?
In-Reply-To: <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94e67edf05062810586d6141f3@mail.gmail.com>
	 <m1br5p3ib8.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a way to lock a particular portion of the memory pages during
kernel bootup? I want to re-use these pages when I load my
application. I *don't* wanna use the idea of reserving some physical
memory and using ioremap. I want something that kernel should be able
to manage this memory but I don't want any other application to use
this memory.

Thanks in advance
Sreeni
