Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSJaH1V>; Thu, 31 Oct 2002 02:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSJaH1V>; Thu, 31 Oct 2002 02:27:21 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37393 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265184AbSJaH1U>;
	Thu, 31 Oct 2002 02:27:20 -0500
Date: Wed, 30 Oct 2002 23:30:54 -0800
From: Greg KH <greg@kroah.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Richard J Moore <richardj_moore@uk.ibm.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: 2.5 Ready list - Kernel Hooks
Message-ID: <20021031073054.GG6406@kroah.com>
References: <OF7660C6E6.D4E17A02-ON80256C5C.005B1F20@portsmouth.uk.ibm.com> <20021024170226.GI22654@kroah.com> <20021025154922.A2303@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025154922.A2303@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 03:49:22PM +0530, Suparna Bhattacharya wrote:
> 
> The downside of course is that one solution may not suit all,
> and in some cases (where the above aspects are not critical) 
> people might prefer as a matter of taste to have explicit subsystem 
> specific calls that clearly indicate the kind of component using the 
> hooks. (Am wondering if this is one of the reasons why LSM  
> would prefer not to link up with kernel hooks. Is that it ?)

Yes, that is one of the main reasons LSM doesn't want to use such a
mechanism.  A simple, explicit, function call is fine for what we need
to do.

thanks,

greg k-h
