Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUEYSP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUEYSP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265032AbUEYSOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:14:49 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:6274 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S265029AbUEYSNp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:13:45 -0400
Date: Tue, 25 May 2004 21:13:44 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: System clock running too fast
Message-ID: <20040525181344.GA4487@elektroni.ee.tut.fi>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200405251939.47165.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405251939.47165.mbuesch@freenet.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 07:39:45PM +0200, Michael Buesch wrote:
> I've got the problem with my server, that the system-clock
> is running really fast. It's running over one second too
> fast in one hour (aproximately).

Try tickadj (comes with ntpd):
  tickadj 9997
