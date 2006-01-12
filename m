Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWALBjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWALBjG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWALBjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:39:05 -0500
Received: from spooner.celestial.com ([192.136.111.35]:26008 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S932680AbWALBjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:39:03 -0500
Date: Wed, 11 Jan 2006 20:38:58 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: OT: fork(): parent or child should run first?
Message-ID: <20060112013858.GB6178@kurtwerks.com>
Mail-Followup-To: =?iso-8859-1?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>,
	Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
References: <20060111123745.GB30219@lgb.hu> <1136983910.2929.39.camel@laptopd505.fenrus.org> <20060111130255.GC30219@lgb.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060111130255.GC30219@lgb.hu>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 02:02:55PM +0100, Gábor Lénárt took 0 lines to write:
> Hello,
> 
> Ok, you're absolutly right here. My problem is to find some solution and not
> to change the behaviour of fork() of course :) It's quite annoying to
> introduce some kind of IPC between parent and childs just for transferring a
> single pid_t ;-) Using exit status would be great (I would transfer "n")

But IPC, especially shared memory, would be great for this if you can
set up the shmid ahead of time. It would certainly be fast.

Kurt
-- 
The study of non-linear physics is like the study of non-elephant
biology.
