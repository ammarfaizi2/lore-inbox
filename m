Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267327AbTAGHPo>; Tue, 7 Jan 2003 02:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTAGHPo>; Tue, 7 Jan 2003 02:15:44 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:39070 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267327AbTAGHPn>; Tue, 7 Jan 2003 02:15:43 -0500
Date: Tue, 7 Jan 2003 09:34:28 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Miles Bader <miles@gnu.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Quiet warnings for def of {_,}_MOD_INC_USE_COUNT when CONFIG_MODULE=n
Message-ID: <20030107073428.GY32708@alhambra>
References: <20030107063239.27428374A@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030107063239.27428374A@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 03:32:39PM +0900, Miles Bader wrote:
> Since `try_module_get(module)' is really just `1' when modules are
> disabled, the compiler bitches.  As these definitions are inlines in a
> header file, this results in a warning for every file that includes
> modules.h.

Miles, 

You're the third or fourth person that sends a patch for this
buglet, including myself. There's a (slightly different) version in
Linus bitkeeper tree already, from Richard Henderson, 2003/01/02. 
-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

