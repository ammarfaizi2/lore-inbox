Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290701AbSBLBnG>; Mon, 11 Feb 2002 20:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290713AbSBLBm4>; Mon, 11 Feb 2002 20:42:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50310 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290701AbSBLBmq>;
	Mon, 11 Feb 2002 20:42:46 -0500
Date: Mon, 11 Feb 2002 17:41:02 -0800 (PST)
Message-Id: <20020211.174102.28786938.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.29104.798819.399971@napali.hpl.hp.com>
In-Reply-To: <15464.28196.894340.327685@napali.hpl.hp.com>
	<20020211.173236.08323394.davem@redhat.com>
	<15464.29104.798819.399971@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 17:36:48 -0800
   
   Umh, perhaps because it adds one level of indirection to every access
   of "current"??

Ummm, which is totally cached and therefore costs nothing?
