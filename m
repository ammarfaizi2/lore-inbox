Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287593AbSAHLpd>; Tue, 8 Jan 2002 06:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287427AbSAHLpY>; Tue, 8 Jan 2002 06:45:24 -0500
Received: from mxzilla1.xs4all.nl ([194.109.6.54]:64527 "EHLO
	mxzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287407AbSAHLpH>; Tue, 8 Jan 2002 06:45:07 -0500
Date: Tue, 8 Jan 2002 12:44:53 +0100
From: "'jtv'" <jtv@xs4all.nl>
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020108124453.F11855@xs4all.nl>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E407@IIS000>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E407@IIS000>; from Dautrevaux@microprocess.com on Tue, Jan 08, 2002 at 10:44:59AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 10:44:59AM +0100, Bernard Dautrevaux wrote:
> 
> NO; the standard here is clear: any access to a volatile object is a side
> effect (see , and optimization is NOT allowed to eliminate side effects, and
> must do them respecting sequence points, even if it determines that the code
> will in fact do nothing 

Thank you.  That makes it absolutely clear.


Jeroen

