Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268033AbRHBEKC>; Thu, 2 Aug 2001 00:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268675AbRHBEJw>; Thu, 2 Aug 2001 00:09:52 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27401 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268033AbRHBEJg>; Thu, 2 Aug 2001 00:09:36 -0400
Date: Thu, 2 Aug 2001 01:09:39 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ivan Kalvatchev <iive@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: tmpfs trash the system
In-Reply-To: <20010801184538.25407.qmail@web13605.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33L.0108020107580.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2001, Ivan Kalvatchev wrote:

> mount tmpfs /mnt/tmp -o tmpfs
> dd if=/dev/zero if=/mnt/tmp/test

So you let tmpfs fill up all memory and swap...

mount -t tmpfs -o nr_blocks=<SIZE> none /mnt/tmp

Where <SIZE> is the maximum size of tmpfs, in pages.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

