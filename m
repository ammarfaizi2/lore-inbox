Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277275AbRJJPgS>; Wed, 10 Oct 2001 11:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277277AbRJJPgK>; Wed, 10 Oct 2001 11:36:10 -0400
Received: from [208.48.139.185] ([208.48.139.185]:47561 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S277275AbRJJPf5>; Wed, 10 Oct 2001 11:35:57 -0400
Date: Wed, 10 Oct 2001 08:36:21 -0700
From: David Rees <dbr@greenhydrant.com>
To: "Chad C. Walstrom" <chewie@wookimus.net>
Cc: linux-kernel@vger.kernel.org, debian-user@lists.debian.org
Subject: Re: Problems with NFS between IRIX Server and Linux client
Message-ID: <20011010083621.A12866@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	"Chad C. Walstrom" <chewie@wookimus.net>,
	linux-kernel@vger.kernel.org, debian-user@lists.debian.org
In-Reply-To: <20011010152602.E11EE184B3@skuld.wk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011010152602.E11EE184B3@skuld.wk>; from chewie@wookimus.net on Wed, Oct 10, 2001 at 10:26:02AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 10:26:02AM -0500, Chad C. Walstrom wrote:
> OK.  Strange problem here with NFS that has been experienced on both
> Debian machines and Red Hat machines.  I believe the problem ties in
> to NFS support in the Linux kernel, but I could be entirely wrong.
> 
> Scenario: Serving a filesystem from IRIX 6.5 host.  Accessing it with
> a Linux 2.4.9 Debian Woody machine.  Directory content listings and
> directory info are not consistently reported to the client.
> 
> Symptoms: For directories with #files approx > 200, filename
> completion in bash does not work, many applications do not show files
> in the directory.

Known problem.  See the NFS patches here, specificall the seedir patch.

http://www.fys.uio.no/~trondmy/src/

-Dave
