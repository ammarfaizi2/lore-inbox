Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUBDBqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUBDBqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:46:45 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:16397 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S266241AbUBDBqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:46:43 -0500
Date: Wed, 4 Feb 2004 02:46:39 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Jean Revertera <marv@altern.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to make "dead key" capslockable with kbd?
Message-ID: <20040204024639.A1617@pclin040.win.tue.nl>
References: <40200681.5000209@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40200681.5000209@altern.org>; from marv@altern.org on Tue, Feb 03, 2004 at 09:37:21PM +0100
X-Spam-DCC: neonova: kweetal.tue.nl 1127; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 09:37:21PM +0100, Jean Revertera wrote:

> I'm currently trying to customize my keymap file, but I have a problem: 
> I'cant make these damn "dead key" correctly capslockable.

Roughly speaking - what you want is impossible.
The kernel knows about 13 types of key, and among these are
KT_LATIN, KT_LETTER, KT_DEAD.
Something cannot be both KT_LETTER and KT_DEAD.

Andries


[And then, on the other hand, little is really impossible with the
Linux keyboard driver. You have 256 keymaps to play with, and can
use capslock to select a new keymap and on that map use any assignments
you like.]
