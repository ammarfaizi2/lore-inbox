Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318281AbSGXXhh>; Wed, 24 Jul 2002 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSGXXhh>; Wed, 24 Jul 2002 19:37:37 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:54144 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S318281AbSGXXhg>; Wed, 24 Jul 2002 19:37:36 -0400
Message-ID: <3D3F38DC.5020400@oracle.com>
Date: Thu, 25 Jul 2002 01:31:40 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020606
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Larson <plars@austin.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.28
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>	<1027547187.7700.67.camel@plars.austin.ibm.com>	<1027547856.7700.70.camel@plars.austin.ibm.com> 	<20020724221423.GD25038@holomorphy.com> <1027549233.7699.80.camel@plars.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson wrote:
> On Wed, 2002-07-24 at 17:14, William Lee Irwin III wrote:
> 
>>On Wed, 2002-07-24 at 16:46, Paul Larson wrote:
>>
>>>>Error building 2.5.28:
>>>
>>On Wed, Jul 24, 2002 at 04:57:35PM -0500, Paul Larson wrote:
>>
>>>Forgot to mention this is an SMP box.  Without CONFIG_SMP it works fine.
>>>-Paul Larson
>>
>>Which drivers?
> 
> CMD640 for certain, but according to rml there are some others that need
> fixing as well.


But, on my UP:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.28; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.28/kernel/net/irda/irda.o
depmod: 	cli
depmod: 	restore_flags
depmod: 	save_flags

(and no, CONFIG_SMP is not set :)


Ciao,

--alessandro

  "my actions make me beautiful / and dignify the flesh"
                 (R.E.M., "Falls to Climb")

