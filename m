Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129930AbQK0Ku3>; Mon, 27 Nov 2000 05:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130573AbQK0KuT>; Mon, 27 Nov 2000 05:50:19 -0500
Received: from 62-6-229-77.btconnect.com ([62.6.229.77]:44804 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129930AbQK0KuB>;
        Mon, 27 Nov 2000 05:50:01 -0500
Date: Mon, 27 Nov 2000 10:21:58 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: number of open fds?
In-Reply-To: <Pine.LNX.4.21.0011261929200.1533-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0011271021060.1202-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

never mind this question:

a) I found count_open_files()

b) for what I needed it for, close_files() is easily enhanceable to return
   this number as well, without having to walk the sets twice

Regards,
Tigran

On Sun, 26 Nov 2000, Tigran Aivazian wrote:

> Hi,
> 
> The kernel/exit.c:put_files_struct() and close_files() are very nice as
> they show how to walk open fds (and close them) and how to free the fd
> array/sets in one go. But is there a _very fast_ way of getting the number
> of fds currently open (without having to walk the sets and test the bits)?
> 
> Regards,
> Tigran
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
