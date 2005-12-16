Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbVLPBab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbVLPBab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVLPBab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:30:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34176 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751241AbVLPBab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:30:31 -0500
Message-ID: <43A2187B.2050909@redhat.com>
Date: Thu, 15 Dec 2005 17:29:31 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH 0/3] *at syscalls: Intro
References: <200512152249.jBFMnXAA016747@devserv.devel.redhat.com> <43A20B0B.5090205@pobox.com>
In-Reply-To: <43A20B0B.5090205@pobox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> It would be nice to add the additional argument to path_lookup(), rather 
> than calling do_path_lookup() everywhere.

path_lookup is unfortunately exported.  If breaking the ABI is no issue 
I'll change it.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
