Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSDIRBr>; Tue, 9 Apr 2002 13:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310295AbSDIRBq>; Tue, 9 Apr 2002 13:01:46 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:60411 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S310258AbSDIRBp>; Tue, 9 Apr 2002 13:01:45 -0400
Message-ID: <3CB31E78.60CE64FE@redhat.com>
Date: Tue, 09 Apr 2002 18:01:44 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-0.16smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Mathew, Tisson K" <tisson.k.mathew@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Inserting modules w/o version check
In-Reply-To: <794826DE8867D411BAB8009027AE9EB911C10AE5@FMSMSX38>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mathew, Tisson K" wrote:
> 
> All ,
> 
> Can we enforce no version check for modules when they are inserted ( insmod

insmod -f

> ) ? If yes , can this be implemented in the module itself ?


no

but it's much nicer to make a "lazy compile" option so that if the
kernel 
doesn't match you compile a new module from source on demand....
It's not hard to do...

Greetings,
   Arjan van de Ven
