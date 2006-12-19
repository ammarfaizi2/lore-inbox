Return-Path: <linux-kernel-owner+w=401wt.eu-S932652AbWLSIBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWLSIBx (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 03:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWLSIBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 03:01:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932652AbWLSIBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 03:01:53 -0500
Message-ID: <45879C5F.7040802@redhat.com>
Date: Tue, 19 Dec 2006 00:01:35 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [take28-resend_2->0 0/8] kevent: Generic event handling mechanism.
References: <11663636322861@2ka.mipt.ru> <458760C9.7080504@redhat.com> <20061219045130.GA28980@2ka.mipt.ru> <458784EE.7080303@redhat.com> <20061219063838.GA23757@2ka.mipt.ru>
In-Reply-To: <20061219063838.GA23757@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> What error messages do you see and what are kevent related config
> changes?

ARCH=um

#define CONFIG_KEVENT_USER_STAT 1
#define CONFIG_KEVENT_PIPE 1
#define CONFIG_KEVENT_POLL 1
#define CONFIG_KEVENT_TIMER 1
#define CONFIG_KEVENT 1
#define CONFIG_KEVENT_SIGNAL 1
#define CONFIG_KEVENT_SOCKET 1



In file included from kernel/kevent/kevent.c:28:
include/linux/kevent.h: In function ‘kevent_init_file’:
include/linux/kevent.h:220: error: ‘struct file’ has no member named ‘st’
include/linux/kevent.h: In function ‘kevent_cleanup_file’:
include/linux/kevent.h:225: error: ‘struct file’ has no member named ‘st’

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
