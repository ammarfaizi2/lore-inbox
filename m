Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289802AbSBKOcs>; Mon, 11 Feb 2002 09:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289766AbSBKOa4>; Mon, 11 Feb 2002 09:30:56 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:9746 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S289757AbSBKOag>;
	Mon, 11 Feb 2002 09:30:36 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200202110620.g1B6KUo146267@saturn.cs.uml.edu>
Subject: Re: KSTK_EIP and KSTK_ESP
To: balbir_soni@hotmail.com (Balbir Singh)
Date: Mon, 11 Feb 2002 01:20:30 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, tigran@veritas.com
In-Reply-To: <F29wLdDnNMZr4DwRMLj000174e4@hotmail.com> from "Balbir Singh" at Feb 08, 2002 12:36:59 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh writes:

> Do we really need these defines, I found that it
> is not used anywhere and defined as deadbeef on
> some architectures. Does it make sense to remove
> these variables from the kernel source?

You should implement these. The names may be x86-specific,
but the purpose is not.

EIP -- user instruction pointer or (eeew!) program counter
ESP -- user stack pointer, as defined by your ABI
