Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291963AbSBTQ2F>; Wed, 20 Feb 2002 11:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291967AbSBTQ1z>; Wed, 20 Feb 2002 11:27:55 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:35495 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291963AbSBTQ1j>; Wed, 20 Feb 2002 11:27:39 -0500
Date: Wed, 20 Feb 2002 11:27:34 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Hugh Dickins <hugh@veritas.com>
cc: Stelian Pop <stelian.pop@fr.alcove.com>,
        Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.4.21.0202201539410.1232-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0202201126400.22285-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


page = vmalloc_to_page(virt); is the right interface and you can find it
in the 2.5.5 kernel, along with the other highpte changes.

	Ingo

