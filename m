Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272196AbRHWCuG>; Wed, 22 Aug 2001 22:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272197AbRHWCt4>; Wed, 22 Aug 2001 22:49:56 -0400
Received: from rj.sgi.com ([204.94.215.100]:2274 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272196AbRHWCtl>;
	Wed, 22 Aug 2001 22:49:41 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] make ide-scsi more selective 
In-Reply-To: Your message of "Wed, 22 Aug 2001 21:46:03 +0200."
             <200108221946.VAA01879@harpo.it.uu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Aug 2001 12:49:45 +1000
Message-ID: <19914.998534985@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 21:46:03 +0200 (MET DST), 
Mikael Pettersson <mikpe@csd.uu.se> wrote:
>Caveat: When listing multiple units, don't use "," to separate their
>names (e.g. units=hdc,hdd). modutils insists that "," separates array
>elements but the actual MODULE_PARM is a single string.

man modules.conf, under options keyword

  If any of the MODULE_SPECIFIC_OPTIONS contain characters that are
  special to the shell (e.g.  space, comma, parentheses) then the
  option must be enclosed in '"..."'.  The '' delimit the option in
  modules.conf, the "" delimit the option when it is passed to the
  shell.  For example,

    abc='"def,ghi jkl (xyz)"'

If that does not work for a string, tell me.

