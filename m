Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUHEV4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUHEV4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267581AbUHEVyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:54:01 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:30393 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S264097AbUHEVxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:53:37 -0400
From: Alessandro Amici <alexamici@fastwebnet.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cputime (1/6): move call to update_process_times.
Date: Thu, 5 Aug 2004 23:54:44 +0200
User-Agent: KMail/1.6.2
Cc: Arnd Bergmann <arnd@arndb.de>, linux-390@vm.marist.edu, arjanv@redhat.com,
       tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       jan.glauber@de.ibm.com
References: <20040805180335.GB9240@mschwid3.boeblingen.de.ibm.com> <200408052157.47603.alexamici@fastwebnet.it> <200408052254.20715.arnd@arndb.de>
In-Reply-To: <200408052254.20715.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408052354.44748.alexamici@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

On Thursday 05 August 2004 22:54, Arnd Bergmann wrote:
> void update_process_times(int user_tick);
> static inline void update_process_times_nonsmp(int user_tick)
> {
> #ifndef CONFIG_SMP
> 	update_process_times(user_tick);
> #endif
> }

I'm sure you mean 'update_process_times_up' 8-)
