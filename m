Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVAMVSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVAMVSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 16:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVAMVPC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 16:15:02 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:31195 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261689AbVAMVMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:12:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=t4FQ8cK92pDUFNojtfzvKZvwcM0grSEhZNn037nwX185z944I1IjaOeblPDp9qNrN+PeF2opqHo2b/Lktfa1kw0VGYtho1rbefNLGFl+CeyP3NLUhNWpkYuyCBPZFkY+AjYM7nPEbMJ8rlg5X4SANl/KFxXquAvTz2AHe+cjKYc=
Message-ID: <a36005b5050113131179d932eb@mail.gmail.com>
Date: Thu, 13 Jan 2005 13:11:58 -0800
From: Ulrich Drepper <drepper@gmail.com>
Reply-To: Ulrich Drepper <drepper@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
In-Reply-To: <20050113134620.GA14127@boetes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050113134620.GA14127@boetes.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aside from all the arguments about why this patch isn't good for the
kernel, everybody should be aware that the ProPolice gcc patches are
pretty unusable.  They rely in recognizing certain tree patterns which
for some architectures do not exist, and for others can look
differently, depending on the optimization.  To paraphrase one of the
gcc developers: "this kind of functionality should be written to work
_with_ gcc, not _against_ it as the propolice patch does".

Before you suggest using something like this patch you better first
inform yourself by asking the people who actually know the code which
is modified.
