Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286413AbSAEXfC>; Sat, 5 Jan 2002 18:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286411AbSAEXew>; Sat, 5 Jan 2002 18:34:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:7437 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286413AbSAEXel>;
	Sat, 5 Jan 2002 18:34:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "kumar M" <kumarm4@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems in exporting symbols 
In-Reply-To: Your message of "Sat, 05 Jan 2002 14:43:20 -0000."
             <F154xe0ymQ1WE9ql2Rk00002adb@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 06 Jan 2002 10:34:28 +1100
Message-ID: <16859.1010273668@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jan 2002 14:43:20 +0000, 
"kumar M" <kumarm4@hotmail.com> wrote:
>I am getting a kernel mismatch error when I insmod a binary module
>compiled on a 2.4.2 kernel (kernel name say linux-2-4-2-v1) on a different 
>system with the same 2.4.2 kernel  but with  a different kernel name 
>(linux-2-4-2-v2). I dont want to recompile the module everytime I give a new 
>name to a kernel or for every different system.
>How do I fix this problem ?

Try insmod -f, but don't complain if it destroys your system.  Modules
tend to be very kernel specific, forcing a module load into a different
kernel is a good way to kill your machine.

