Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSDIPkH>; Tue, 9 Apr 2002 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSDIPkG>; Tue, 9 Apr 2002 11:40:06 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:11637 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S293187AbSDIPkF>;
	Tue, 9 Apr 2002 11:40:05 -0400
Date: Tue, 9 Apr 2002 16:39:44 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
cc: Davide Libenzi <davidel@xmailserver.org>, <linux-kernel@vger.kernel.org>
Subject: RE: system call for finding the number of cpus??
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A44520@tayexc13.americas.cpqcorp.net>
Message-ID: <Pine.LNX.4.33.0204091639020.1098-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Kuppuswamy, Priyadarshini wrote:

> I don't think that (sysconf(_SC_NPROCESSORS_CONF)) command works on linux. It works on Unix. I tried that. It returns 1 when there are 4 processors on linux.

it works:

# /usr/bin/getconf _NPROCESSORS_ONLN
2

If it didn't work then glibc (and other rpms that take advantage of it)
would have taken a lot longer to compile :)


