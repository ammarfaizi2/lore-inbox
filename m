Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKZUB1>; Sun, 26 Nov 2000 15:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129770AbQKZUBR>; Sun, 26 Nov 2000 15:01:17 -0500
Received: from 213-123-72-179.btconnect.com ([213.123.72.179]:29191 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S130063AbQKZUBG>;
        Sun, 26 Nov 2000 15:01:06 -0500
Date: Sun, 26 Nov 2000 19:33:00 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: number of open fds?
Message-ID: <Pine.LNX.4.21.0011261929200.1533-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The kernel/exit.c:put_files_struct() and close_files() are very nice as
they show how to walk open fds (and close them) and how to free the fd
array/sets in one go. But is there a _very fast_ way of getting the number
of fds currently open (without having to walk the sets and test the bits)?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
