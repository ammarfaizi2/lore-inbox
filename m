Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289899AbSA3QP1>; Wed, 30 Jan 2002 11:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289891AbSA3QN3>; Wed, 30 Jan 2002 11:13:29 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22484 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289456AbSA3QMh>;
	Wed, 30 Jan 2002 11:12:37 -0500
Date: Wed, 30 Jan 2002 11:12:33 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: DervishD <raul@viadomus.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Message-ID: <20020130111233.A21325@havoc.gtf.org>
In-Reply-To: <E16VtWb-0002kV-00@DervishD.viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VtWb-0002kV-00@DervishD.viadomus.com>; from raul@viadomus.com on Wed, Jan 30, 2002 at 01:07:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:07:37PM +0100, DervishD wrote:
>     The problem is that I don't want to copy the definitions I need
> from linux/fs.h, because this will lead to problems if those
> definitions change. Anyway this is not an issue, because by changing
> the running kernel those definitions in fact may not be valid...
> 
>     Resuming: I don't know how properly address this problem.

Go ahead and copy.  If ioctl interfaces change, then binary
compatibility just changed too.  By nature that will be changed
infrequently, if at all.

	Jeff




