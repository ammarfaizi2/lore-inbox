Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261177AbSIZNZH>; Thu, 26 Sep 2002 09:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSIZNZG>; Thu, 26 Sep 2002 09:25:06 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:47371 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261177AbSIZNZG>; Thu, 26 Sep 2002 09:25:06 -0400
Date: Thu, 26 Sep 2002 09:29:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm3
In-Reply-To: <20020926124244.GO3530@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0209260926480.1819-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, William Lee Irwin III wrote:

> In my experience fget() is large even on UP kernels. For instance, a UP
> profile from a long-running interactive load UP box (my home machine):

I can affirmative that;

6124639 total                                      4.1414
4883005 default_idle                             101729.2708
380218 ata_input_data                           1697.4018
242647 ata_output_data                          1083.2455
 35989 do_select                                 60.7922
 34931 unix_poll                                218.3187
 33561 schedule                                  52.4391
 29823 do_softirq                               155.3281
 27021 fget                                     422.2031
 25270 sock_poll                                526.4583
 18224 preempt_schedule                         379.6667
 17895 sys_select                                15.5339
 17741 __generic_copy_from_user                 184.8021
 15397 __generic_copy_to_user                   240.5781
 13214 fput                                      55.0583
 13088 add_wait_queue                           163.6000
 12637 system_call                              225.6607

-- 
function.linuxpower.ca

