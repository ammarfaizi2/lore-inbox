Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290326AbSAPB1g>; Tue, 15 Jan 2002 20:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290335AbSAPB0N>; Tue, 15 Jan 2002 20:26:13 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:21538 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290329AbSAPBZT>; Tue, 15 Jan 2002 20:25:19 -0500
Date: Tue, 15 Jan 2002 20:25:18 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
Message-ID: <20020115202518.M17477@redhat.com>
In-Reply-To: <20020115192048.G17477@redhat.com> <Pine.LNX.4.33.0201151628440.1140-100000@penguin.transmeta.com> <20020115194316.I17477@redhat.com> <1011144263.8754.22.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1011144263.8754.22.camel@phantasy>; from rml@tech9.net on Tue, Jan 15, 2002 at 08:24:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 08:24:22PM -0500, Robert Love wrote:
> I get this compile error under 2.5.3-pre1, too.  System is SMP.  2.5.2
> worked fine.  I don't see a thing in the patch that would cause this ...

Uh, brlock.c probably should be including threads.h...

-- 
Fish.
