Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262964AbSJGKMz>; Mon, 7 Oct 2002 06:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262965AbSJGKMz>; Mon, 7 Oct 2002 06:12:55 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:57098 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S262964AbSJGKMy>;
	Mon, 7 Oct 2002 06:12:54 -0400
Date: Mon, 7 Oct 2002 10:17:50 +0000
From: Eduardo =?iso-8859-1?Q?P=E9rez?= <100018135@alumnos.uc3m.es>
To: linux-kernel@vger.kernel.org
Subject: [RFC] namespace clean
Message-ID: <a6cf5427338512cb0ae6b015e16b896a@alumnos.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Linux kernel has a cryptic api namespace that confuses
many people when trying to code for the Linux kernel. People can't know
by direct examination of a symbol to what package belongs. Also symbols
can't be easily sorted by package.

I'm suggesting to use a cleaner namespace like
package_object_method and package_function
If this is accepted, symbols from new code should follow this
naming, and current symbols should start the transition to this cleaner
namespace.

If anybody like me think that this would help people to code for the
Linux kernel it would be a good idea to start this transition to a
cleaner namespace.

Most drivers and new core kernel api have a very clean namespace but
some old api don't.

What are your thoughts about this ?
