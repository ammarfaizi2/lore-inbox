Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSAIUpO>; Wed, 9 Jan 2002 15:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289016AbSAIUpF>; Wed, 9 Jan 2002 15:45:05 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:3600 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289015AbSAIUos>; Wed, 9 Jan 2002 15:44:48 -0500
Date: Wed, 9 Jan 2002 21:44:45 +0100
From: jtv <jtv@xs4all.nl>
To: =?iso-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: "J.A. Magallon" <jamagallon@able.es>, Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020109214445.C11890@xs4all.nl>
In-Reply-To: <20020108012734.E23665@werewolf.able.es> <20020109204043.T1027-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020109204043.T1027-100000@gerard>; from groudier@free.fr on Wed, Jan 09, 2002 at 08:47:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 08:47:15PM +0100, Gérard Roudier wrote:
> On Tue, 8 Jan 2002, J.A. Magallon wrote:
> 
> There is nothing in this code that requires the compiler to allocate
> memory for 'b'. You just invent the volatile constant concept. :)

What's so strange about volatile constant?  In C, const means you're
not allowed to modify something--not that it won't change.  A read-only
hardware register, for instance, would be const and volatile.


Jeroen

