Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271321AbRH3FMz>; Thu, 30 Aug 2001 01:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271326AbRH3FMq>; Thu, 30 Aug 2001 01:12:46 -0400
Received: from vitelus.com ([64.81.243.207]:45066 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S271321AbRH3FMa>;
	Thu, 30 Aug 2001 01:12:30 -0400
Date: Wed, 29 Aug 2001 22:12:46 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Diet /sbin/hotplug package released
Message-ID: <20010829221246.B30945@vitelus.com>
In-Reply-To: <20010829120440.B12825@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010829120440.B12825@kroah.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2001 at 12:04:40PM -0700, Greg KH wrote:
>    is 59221 bytes.  The current linux-hotplug system needs this file,
>    plus all of the linux-hotplug scripts and bash and awk to work.

Hrm, why does it use bash-specific shell features? That's very bad.
POSIX would be a much cleaner spec to conform to.
