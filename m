Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbSIXVpk>; Tue, 24 Sep 2002 17:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSIXVpj>; Tue, 24 Sep 2002 17:45:39 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3024 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261811AbSIXVpj>;
	Tue, 24 Sep 2002 17:45:39 -0400
Message-ID: <3D90DE24.C772A1FD@us.ibm.com>
Date: Tue, 24 Sep 2002 14:50:28 -0700
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [evlog-dev] Re: alternate event logging proposal
References: <200209242127.g8OLRTxN005667@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> 
> Larry Kessler <kessler@us.ibm.com> said:
> 
> [...]
> 
> > Event logging uses real-time signaling to notify a process that's registered
> > for notification that an event matching the criteria defined during
> > registration has been written to the event log.  When notified, the process
> > can read the entire event from the event log and then do whatever.
> 
> How is said event found? By scanning the whole log?
  
No, the record id of the associated event is obtained by calling a function
after your process is notified.  See link in previous note for full API
descriptions.
