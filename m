Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291825AbSBHU5Q>; Fri, 8 Feb 2002 15:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291812AbSBHU5E>; Fri, 8 Feb 2002 15:57:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44673 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291806AbSBHU5A>;
	Fri, 8 Feb 2002 15:57:00 -0500
Date: Fri, 08 Feb 2002 12:55:22 -0800 (PST)
Message-Id: <20020208.125522.48531421.davem@redhat.com>
To: balbir_soni@hotmail.com
Cc: linux-kernel@vger.kernel.org, tigran@veritas.com
Subject: Re: KSTK_EIP and KSTK_ESP
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F29wLdDnNMZr4DwRMLj000174e4@hotmail.com>
In-Reply-To: <F29wLdDnNMZr4DwRMLj000174e4@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Balbir Singh" <balbir_soni@hotmail.com>
   Date: Fri, 08 Feb 2002 12:36:59 -0800

   Do we really need these defines, I found that it
   is not used anywhere and defined as deadbeef on
   some architectures. Does it make sense to remove
   these variables from the kernel source?
   
Perhaps your copy of grep is buggy, check out
fs/proc/array.c which does make use of those macros.

