Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131029AbRAMS3L>; Sat, 13 Jan 2001 13:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131162AbRAMS3F>; Sat, 13 Jan 2001 13:29:05 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59872 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131221AbRAMSZh>;
	Sat, 13 Jan 2001 13:25:37 -0500
Message-ID: <3A607014.EBA7A6D7@wanadoo.fr>
Date: Sat, 13 Jan 2001 16:11:16 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.76 [fr] (X11; U; Linux 2.4.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ankry@green.mif.pg.gda.pl
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre2/3 and Pentium-III not stable
In-Reply-To: <200101131059.LAA25032@sunrise.pg.gda.pl>
Content-Type: multipart/mixed;
 boundary="------------DD1AE860BD1BDB6C98906563"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DD1AE860BD1BDB6C98906563
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Andrzej Krzysztofowicz wrote:
> 
> "Pierre Rousselet wrote:"
> > Pentium-III 256Mo
> > For testing, I try to compile glibc. The start is good.
> > When the process PID reaches a value around 22000
> > (variable), all goes wrong. Make gives error messages
> > such as :
> >
> > make[2]: *** No rule to make target
> > `../sysdeps/wordsize-32/bits/wordsi:e.h'
> > make[2]: *** No rule to make target
> > `/usr/lib/g#c-lib/i686-pc-linux-gnu/2.95.2/include/stddef.h'
> 
> As "z" / ":" and "c" / "#" differ only on a single bit
> it looks like a bad memory problem.

I got the attached kernlog in an other compiling test
writing Kernel BUG at page_alloc.c and swap.c. The PID of
as is then 26349.

------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
--------------DD1AE860BD1BDB6C98906563
Content-Type: application/x-gzip;
 name="bug.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bug.gz"

H4sICHJtYDoCA2J1ZwDVmFtv2zYUgN/3K9i3DdpmkiIpysAe1mErVmxAgK57KQKBN6VCZEmQ
lDbZr9+haMtypoRO2qGbX0wenRsPeT7Kfq0aRFJE+JaJLeZoV9XtDbp2fePqLXqpLBo+qg61
ZTm4Eblm7O8QlikvDcboq9ePWv/5+xZdV3VdNVeo61vjhgGpIWbl4xVl79wW/dHfeduxRX6O
mrZxt9UwQhaT1nedunIPuavVMKIdhPQ6veucGp1FFI0VCM9P4bDwW+OcHdBO3X7R/LP/Tf7/
vrsvvrTwjV6+fYXUiLxFoeq6Nd+bbZa+iFlXzQdVVxa1netVY7cI43hL/XTxdovgE1X8+deL
oIgJ3r4rplUXPsWhaK+TlG2yTFxGnfzy24+v3kyZEUwljek7dRuWAfolBHca5oZQ6rhlfm78
HBNHsZB+bmd9TKLOh+qgnIrJGOYmtSXHcnKuu9kZ9vOhC88zx03MuR28LZmSOg6HwzBifXGE
29ddBVtJRcryb9EwKnPti/7DlAfk9U3M1RtvMhVJ64zJMJBW7FfG8mM951rMRTBpXhIK+c41
jYXbfwymmPMyPfjEPi5VVqqQgMN7CcM0DGSuVjI5OxwhpRKLtRiXKe0ERCGcKQnhsMRZ7nfS
rzoNA7aXyP0g2i3QjtDpykDDQw/M7Z9QaAAq2SU66YyECpCCcBYV0JjBzCjz3iVEiA3JKKj8
BbJJA3r3yiWMkg0X3iFgZCx2O9UlRII732XvdrvuZkxSuREYZrYtvFJCWL7hDGzOrJo3nEKW
6qYeE5nRDYGiX95/gA/iruogP6dswqTc8Ek23A1BRHK+oXjKuO/bvjCtdQmnU4rRhGJ1B1/Q
OSXCGskUGTghxg8yDXsH+4gyhohAQiGmEZAAjreWiGg4GH4Kx/5+BPFJ6BXPQa84F73ic6BX
PI5eEdP/FPRGVzSh1zjLhAlotfNcPYxewl0O0Is5fxp6xQPovb7pLLwh7fmbnbDXJ7LGXvF8
9s7FmKsAykzn0hwHsXAHGFrOiJZ4b5jrRRQvSbE8ZS8VoLMv9iKTc8MRrkuVyv0ggJ1hLu1i
LVAxicMjbbEWQUJT5eNKh88Id8JedzvS4mNfjc7vCBCK4sszpYQvxFduLDS0+bWHHHkE4FXt
dh72cCbUcNcYIHe2CQZ+WlQNIAr0GdmkYgXBDxQvGLe1LfRNWbp+AIgD98Hr/vwlFC4Cmvob
IpgW4/tAYDzpRePEqvp5ySq3nD1KVn/3AVOhci9ihnGorhitQ3VF8RSq1ikzVh+g4OHia9rp
UBAJ20nuwXXN2WNwXdFfwlV9ElzXnE9wnZyVM1yPL3AncCVLuJaljjp/AlxXrGe4+mNg92xl
99la/oOtK66WbIWShwFRhzdOLY8lWOKP5tTpkxdNgsv79FkJd3zR1JqTbKqXo2l+5NfknJf2
UFpx3DBDGMtLLRdX2tnhcMYoOxqGr2xab0lKG++/E272DkhWA62m4+6KwagGkJNuKPOYC/uS
EJwDc8RZzFlLPpbRKnM0YmAhkQKqAHa4V1gKZRBKL1xG4HRL6HN/1EeMn/qj/r+ay/p/Pzz8
9/M3sdseEbITAAA=
--------------DD1AE860BD1BDB6C98906563--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
