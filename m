Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933633AbWKWMhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933633AbWKWMhG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 07:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933631AbWKWMhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 07:37:05 -0500
Received: from smtp3.orange.fr ([193.252.22.28]:6236 "EHLO
	smtp-msa-out03.orange.fr") by vger.kernel.org with ESMTP
	id S933633AbWKWMg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 07:36:56 -0500
X-ME-UUID: 20061123123655651.9EFD71C003D2@mwinf0303.orange.fr
Subject: Re: coping with swap-exhaustion in 2.4.33-4
From: Xavier Bestel <xavier.bestel@free.fr>
To: Yakov Lerner <iler.ml@gmail.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
References: <f36b08ee0611230430k9b2b625qc8d1b93031e09d14@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 13:36:52 +0100
Message-Id: <1164285412.13074.131.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 14:30 +0200, Yakov Lerner wrote:
>     Where can I read anything about how kernel is supposed to
> react to the 'swap-full' condition ? We have troubles on the
> production machine which routinely arrives to the swap-full state
> no matter how I increase the swap, because user proceses multi-fork
> and then want to allocate a lot of virtual memory.

Did you disable memory overcommit ?

	Xav

