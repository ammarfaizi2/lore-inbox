Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262644AbSJBVzm>; Wed, 2 Oct 2002 17:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262646AbSJBVzl>; Wed, 2 Oct 2002 17:55:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55999 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262644AbSJBVzl>; Wed, 2 Oct 2002 17:55:41 -0400
Subject: Re: compile failure in orinoco_cs.c (from bk pull)
From: Paul Larson <plars@linuxtestproject.org>
To: pee@erkkila.org
Cc: lkml <linux-kernel@vger.kernel.org>, hermes@gibson.dropbear.id.au
In-Reply-To: <3D9B689B.2040807@erkkila.org>
References: <3D9B689B.2040807@erkkila.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Oct 2002 16:57:06 -0500
Message-Id: <1033595826.11325.11.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 16:43, Paul E. Erkkila wrote:
> The orinoco_cs.c wireless driver no longer compiles after yesterdays
> tree changes.
I think you posted this simultaneous to someone posting a patch for it.
Basically just remove the #include <linux/tqueue.h> line and all should
be good.

-Paul Larson

