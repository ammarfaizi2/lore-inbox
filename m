Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRLLPML>; Wed, 12 Dec 2001 10:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280664AbRLLPMC>; Wed, 12 Dec 2001 10:12:02 -0500
Received: from mail.ccur.com ([208.248.32.212]:44811 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id <S280588AbRLLPLx>;
	Wed, 12 Dec 2001 10:11:53 -0500
Subject: Re: [RFC] Multiprocessor Control Interfaces
From: Jason Baietto <jason.baietto@ccur.com>
To: Tim Hockin <thockin@sun.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C164D93.A52BC1C2@sun.com>
In-Reply-To: <200112110138.fBB1cqS09363@www.hockin.org>
	<1008088311.16656.4.camel@soybean>  <3C164D93.A52BC1C2@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 12 Dec 2001 10:11:43 -0500
Message-Id: <1008169908.22359.2.camel@soybean>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 13:16, Tim Hockin wrote:
> Jason Baietto wrote:
>
> > support it in my "run" tool, though I fear that it would always be
> > functionally limited without /proc present.
> 
> Adding /proc/ interfaces like cpus_allowed or similar is just gravy
> on top of pset, which I think is a good interface.

Sorry for the ambiguity.  My comment was about the functionality of
the "run" tool itself being limited without /proc support.

Although I agree that ultimately "run" is gravy, our customers think
it's pretty tasty gravy :-)  It's very convenient to write a shell
script to start up a complex application without having to reference
pids anywhere and without having to modify any of the programs in
the application to make them CPU affinity aware.  Combined with run's
ability to tune scheduling parameters, you have a very simple but
powerful way to experiment with and tune application performance.

The run tool also allows you to quickly move processes around by
specifying lists of pids, process names, process groups or users,
but /proc is needed for anything more interesting than pids.

Take care,
Jason
--
Jason Baietto
jason.baietto@ccur.com
http://www.ccur.com/realtime/oss

