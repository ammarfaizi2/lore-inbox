Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTANRWK>; Tue, 14 Jan 2003 12:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264822AbTANRWK>; Tue, 14 Jan 2003 12:22:10 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:6275 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S264818AbTANRWJ>; Tue, 14 Jan 2003 12:22:09 -0500
Date: Tue, 14 Jan 2003 17:31:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Patrick Mochel <mochel@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, Christoph Hellwig <hch@lst.de>,
       Hugh Dickins <hugh@veritas.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <Pine.LNX.4.33.0301140958391.1025-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0301141730350.1241-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, Patrick Mochel wrote:
> Out of curiosity, how large are the microcode updates? Or rather, what is
> the range of sizes that you've seen?

Each chunk is 2048 bytes long of which only 2000 bytes are the data bits
sent to the cpus. See struct microcode in <asm/processor.h>

Regards
Tigran

