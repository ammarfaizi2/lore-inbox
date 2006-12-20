Return-Path: <linux-kernel-owner+w=401wt.eu-S965121AbWLTPOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWLTPOe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 10:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWLTPOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 10:14:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:11366 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965121AbWLTPOd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 10:14:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:references:date:in-reply-to:message-id:user-agent:mime-version:content-type:sender;
        b=JFQPebaG4tdHYJOOyeBOk32JPsvni4U296MeRmdUg6rbMUaFz6F3dYAwhxLR32nqqkrJVZRvBORjLjiBYRFEaDK9477zGrUgKdgF3hgbF9Y0isHSI1f1+FCn5qLYEta/d00l30c5NpL3F9lpv6j+Z10aNmSv/0883JBUHSSPiCU=
From: David Wragg <david@wragg.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] procfs: export context switch counts in /proc/*/stat
References: <787b0d920612192140o37a28e8fnccdd51670cb9a766@mail.gmail.com>
	<878xh2aelz.fsf@wragg.org>
	<1166622487.3365.1386.camel@laptopd505.fenrus.org>
	<871wmuab01.fsf@wragg.org>
	<1166626290.3365.1412.camel@laptopd505.fenrus.org>
Date: Wed, 20 Dec 2006 15:13:12 +0000
In-Reply-To: <1166626290.3365.1412.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Wed\, 20 Dec 2006 15\:51\:29 +0100")
Message-ID: <87wt4m8ut3.fsf@wragg.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> On Wed, 2006-12-20 at 14:38 +0000, David Wragg wrote:
>> (When I try the script, stap complains about the lack of the kernel
>> debuginfo package, which of course doesn't exist for my self-built
>> kernel.  After hunting around on the web for 10 minutes, I'm still no
>> closer to resolving this.  But I look forward to playing with
>> systemtap once I get past that problem.)
>
> what worked for me is copying the "vmlinux" file to /boot as
> /boot/vmlinux-`uname -r`

Thanks, that's got it working.
