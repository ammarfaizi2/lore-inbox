Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278342AbRJSIbq>; Fri, 19 Oct 2001 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278341AbRJSIbg>; Fri, 19 Oct 2001 04:31:36 -0400
Received: from rj.sgi.com ([204.94.215.100]:64142 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278340AbRJSIb0>;
	Fri, 19 Oct 2001 04:31:26 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5 
In-Reply-To: Your message of "Fri, 19 Oct 2001 04:09:05 -0400."
             <3BCFDFA1.FF7661FE@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Oct 2001 18:31:52 +1000
Message-ID: <21727.1003480312@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001 04:09:05 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>"Henning P. Schmiedehausen" wrote:
>> And a version field! Please add a version field right to the
>> beginning. This would make supporting legacy drivers in later versions
>> _much_ easier.
>
>This is not a structure that is directly exposed to userspace, so it
>doesn't need to be versioned.

Will you want modutils support for this new struct?  If so it needs
a version field.

