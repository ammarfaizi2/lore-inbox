Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291273AbSBMAhL>; Tue, 12 Feb 2002 19:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291277AbSBMAg6>; Tue, 12 Feb 2002 19:36:58 -0500
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:43706 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S291273AbSBMAgw>; Tue, 12 Feb 2002 19:36:52 -0500
Date: Tue, 12 Feb 2002 19:36:49 -0500
From: Tom Vier <tmv5@home.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
Message-ID: <20020213003649.GA13722@zero>
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 02:12:49PM +0100, Roy Sigurd Karlsbakk wrote:
> Does anyone know if it'll be hard to enable a <em>secure</em> deletion of
<snip>
> Is this hard/possible/doable?

read:

http://wipe.sf.net/

it's the site of my file wiper. note the list of situations in which it
definetly will not work. if you really don't want plaintext laying around,
then using an encrypted fs is the only way.

a new version will be out soon, with a couple minor bug fixes. wipe is
mostly useful for wiping a drive you're selling of personal stuff. 

also, don't forget about swap. if, for example, a proc reads the contents of
a file from an encrypted fs into a buffer, the buffer can be written to swap
in plaintext.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
