Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbUAETxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265304AbUAETxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:53:21 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:53632 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S265229AbUAETxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:53:13 -0500
Date: Mon, 5 Jan 2004 20:38:17 +0100
From: GCS <gcs@lsc.hu>
To: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1 affected?
Message-ID: <20040105193817.GA4366@lsc.hu>
References: <1073320318.21198.2.camel@midux> <Pine.LNX.4.58.0401050840290.21265@home.osdl.org> <1073326471.21338.21.camel@midux> <Pine.LNX.4.58.0401051027430.2115@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401051027430.2115@home.osdl.org>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 10:31:02AM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
[snip]
> And because nobody has an exploit yet, and one may be hard or
> impossible to create?
 There _is_ an exploit: http://isec.pl/vulnerabilities/isec-0013-mremap.txt
"Since no special privileges are required to use the mremap(2) system
call any process may misuse its unexpected behavior to disrupt the kernel
memory management subsystem. Proper exploitation of this vulnerability may
lead to local privilege escalation including execution of  arbitrary code
with kernel level access. Proof-of-concept exploit code has been created 
and successfully tested giving UID 0 shell on vulnerable systems."

Cheers,
GCS
