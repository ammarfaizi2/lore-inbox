Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262128AbVERImz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbVERImz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 04:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVERImz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 04:42:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33458 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262128AbVERImu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 04:42:50 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: ross@lug.udel.edu
Cc: Valdis.Kletnieks@vt.edu, Karel Kulhavy <clock@twibright.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050518063014.GA7053@jose.lug.udel.edu>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel>
	 <1116354762.31830.12.camel@mindpipe>
	 <20050517192412.GA19431@kestrel.twibright.com>
	 <200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
	 <20050518063014.GA7053@jose.lug.udel.edu>
Content-Type: text/plain
Date: Wed, 18 May 2005 04:42:49 -0400
Message-Id: <1116405769.4153.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-18 at 02:30 -0400, ross@lug.udel.edu wrote:
> On Tue, May 17, 2005 at 04:27:44PM -0400, Valdis.Kletnieks@vt.edu wrote:
> > I was hoping somebody would explain how to get 'dmix' plugin working in the
> > kernel - then I could get rid of esd ;)  (Note that running something in
> > userspace that accepts connections, runs dmix on them, and then creates one
> > thing spewing to /dev/pcm isn't a solution - I've already *got* esd, warts and all)
> 
> 
> In all honesty - don't bother.  esd does the job better, faster, more
> flexibly, and without the hassle.
> 

This problem is fixed with the upcoming ALSA 1.0.9 release - dmix will
"just work".  It's been a big area of development lately.

Lee

