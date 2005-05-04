Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVEDR50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVEDR50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVEDR4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:56:05 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:44796 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261273AbVEDRzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:55:13 -0400
Date: Wed, 4 May 2005 10:54:58 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andr? Pereira de Almeida <andre@cachola.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A patch for the file kernel/fork.c
Message-ID: <20050504175457.GA31789@taniwha.stupidest.org>
References: <4278E03A.1000605@cachola.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4278E03A.1000605@cachola.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 11:46:18AM -0300, Andr? Pereira de Almeida wrote:

> -       if (tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {
> +       if (mm && tsk->clear_child_tid && atomic_read(&mm->mm_users) > 1) {

did you actually see a problem here?
