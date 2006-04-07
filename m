Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWDGS6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWDGS6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 14:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWDGS6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 14:58:41 -0400
Received: from pproxy.gmail.com ([64.233.166.179]:35237 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964887AbWDGS6k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 14:58:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ekpVXmPjqE58MsF2CN9Ui79vZBR+X7aJZd/2zbzsm9LRgmi6t3RZGVxYT1UfS4CWNHGdJM2gKW14GyQczOzBK9Rqhvh4/8OAeh03AgPpWUkZVigUfezgOgbn54IfzYE7PL10EhfLPViTWPE4I1NEQCDm0SFXbBgTx1ggPfQyaio=
Message-ID: <bda6d13a0604071158x33080de3ya8016dde59c2d97f@mail.gmail.com>
Date: Fri, 7 Apr 2006 11:58:40 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: wait4/waitpid/waitid oddness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m1acaxnt1x.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920604052038i3a75bdb6ic0818d93805b881b@mail.gmail.com>
	 <m1acaxnt1x.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Albert Cahalan" <acahalan@gmail.com> writes:
>
> > The kernel prohibits:
> >
> > 1. WNOHANG on waitpid/wait4
>
> Not 2.6.17-rc1, and not for a lot of earlier kernels.
> At least not on ingress, and just skimming the code
> I can't see any deeper checks that would prevent this.
>
> > 2. __WALL on waitid
> >
> > Why? I need both at once.
>
> Which kernel is failing, and how?

LKNL 2.6.16.1 has this check. Haven't checked any others.
