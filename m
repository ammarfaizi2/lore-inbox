Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283984AbRLAFx5>; Sat, 1 Dec 2001 00:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283982AbRLAFxs>; Sat, 1 Dec 2001 00:53:48 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:6884 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S284014AbRLAFx1>; Sat, 1 Dec 2001 00:53:27 -0500
Message-ID: <3C087023.9683B8AF@starband.net>
Date: Sat, 01 Dec 2001 00:52:36 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it normal for freezing while...
In-Reply-To: <3C085B04.50ABE0B5@starband.net> <3C0867A3.5119D2BC@zip.com.au>
Content-Type: multipart/mixed;
 boundary="------------045F1643A1F0FCCCBC8416DE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------045F1643A1F0FCCCBC8416DE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Wow, responsiveness is wonderful with these patches.

Will they make it into 2.4.17, (ie: I've seen the -pre2 changelog, did
you incorporate them into -pre2)?
Even throughout the entire dd, it remained responsive
(mouse/cursor/network/etc).

Attached is the vmstat log during the dd.


Andrew Morton wrote:

> war wrote:
> >
> > Is it normal for a system to lockup while creating a 3GB test file?
> >
>
> Seems that way.
>
> It also seems that yesterday I sent you the URL of two patches:
>
> http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/vm-fixes.patch
> http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/elevator.patch
>
> and I explicitly asked you to report on the result of applying them?
>
> If you apply them, you'll find that the problem goes away. If you're
> using ext3, you'll get better results if you mount with the `noatime'
> option.
>
> So please - test the patches, report the results.  It's how things
> work around here.  Sometimes :)
>
> Thanks.
>
> -

--------------045F1643A1F0FCCCBC8416DE
Content-Type: application/octet-stream;
 name="vmstat.log.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="vmstat.log.bz2"

QlpoOTFBWSZTWcIN6Q4ACIr5gGMQEABAAH/gP2PeoGAX2tB3rvTx9BXtrg+81HN7hruu7dt3
kNZzuS2ek1WdFt3W5ruyRodbb6NKAPe25ldAGtraNF2XwDCASUqAAGgAlMJEKlGIAGgA02lE
Q1MaAmRgAk0kU9J6lQAAAAmqSmimnlNlGE0009GiCTSQjUpTTAABGYVVJUq17dubFknnZcS9
3YWzC8wdRqpis8SA/209vBNU+r92T6o55vT4UIXu8FMqqgXVCNvSZefbYrW1V5rVGo33XFR8
ss5yeseW+bKWtKY5JzsLLGLK719NBN57Rmuqz3bIzJqsd3o2OrRli3MZ6qy1Own1Ty73WMr3
HK1wKEDj/wg/hAIIBFAeVv61P5W/k2Lr2RuaNHzkS62bLyOmgsusvB2SxaMre2DeOE3EaKGW
pub/Qg/3IP6EH/xB4EEe3fyNLK4k0yoLq0JMVkJUAKgVBNsmts13J1T3Tsm3dz5658d4Fxtt
ctbadFNCCqBURqVFB0WmhMMwsTg4pbYnIxIUatiUEVJSEQJDVDiaGWcgEiUgBQDSbTjQox2a
ixMkrZGkWDsYnSSWWkjpRxqUFVaSxpF5+nDdXn6W2eb6++nPfdVJ4z3svCAkHcVsDex325ei
lSG9NbxN1dVYfTeZJvNGWDOTGqXTuJIuWdjII3GTKLm+FSeFgEVKM2M2czM1FQ7QqLzKF5S1
3l5nueZ3eHnY8nhD2Act06mIKLIocrqZEpJjZyB1DttxqSFohtkMJFoQO6TEC4Hc9INZAtSQ
JiJSwYHNi1XV1UoedvRV7QkYBpAwAnI5QEJzoMIjKtSUCpZQIaKL682qFtoKY7pqUgSpreQz
afRkC0kurtumO4aBYFg6QRUF05UBHljc04Cmmd4TU1ljbYusaRNZ3cOMk81ZtvF0CYanoMrI
dPbixgwUDgIY5GAFlFRgoEYxUEVCTicXS3mWRsGXVBLZrC1q0W3Hd3rt5zNlZzfK41Vi11WY
tnO2g83eGWGNoAQ0YRkNFG8yYMtBtkYsi+N4aMARHBmXCCxLkypOTBBVkLMKgUzJEiDBUaSc
zKrcaEy5AQKVtInGaTzZ22d73yzmG66/CCieY3EMToDoA4WhCoileMzHXbLHmS2ZG6IY+zeF
4ebkRnEdQJGBqzA5shJ440eVi928cb21w38LNtK6p5J0T1T6TzQjgylfY+YKYEg1FkBYBZIX
DoU0Ji0osVBZI0wxyWKGW21YOgTRr8vyhphmaD04MTdwNdX5tlMQjNHwKjhbUgVBU1MKZCy2
6zJUrILJczAqgZ1sSNdbfN5+cv5HhgdAzRHev8+3bxWMz6Xe6TvLzY2D2zAB99ih2Y0LvfZQ
F5x4O2OicNexozFN+5umoY5ahNvlpggc0h46VgbyYe+8mxgb24HJw4ZZfASHPQaaWHsJibBg
ciIDJR5rAs8yipHJAly780YLcwQHeS0NQVF0re7lViymJjKpwQKcctiec7eEcViIiRVoQZrT
zMrHsk95ddIc5HVFRqao92xjvvj4uvinVGd2TbI6RbYlZ79Kr3h142qm5NiW2q1RFdrLro3J
bRqSERGceYE2kusAh4jbDBgYiwIoFhIeeZ5oMxpaXTzne0rTizsZVFZO2owyIDNjAz5Bdt1T
HHbIFJ4hLAmM8YEhe8MrNo0AQZlgqWB7riUcfONXV0BVEAoXkCkBzZFhZD5fcmcaHWAApIQ0
XmQJ3fclQntnUA7CcZmEPee8Jj3VJWEwPtYZn2snGNEf31NWD1k9vk16ARV9RYQ+MDbxd3nl
8Q34lDvfMdcFw8Z7akJWti1A3qHSAH1oVnVUZcT2iIzPCeniqQtvJsV74bqS4ciU4yNwUGxp
y4mY0vHNKjbRWBUoxeaNaYrDGVkFa2FaVki4Q/2EYT/IRhPxgyTwT0TSeUnwmhSXjUsDFMTK
sYkzJWYTMZSVlTCJEIIAgQ6EEk+ligfblCKQgsPpyzWq/ZQCpiQKMUhFbQrBiMrRYqKCqQEQ
NpUgoktzLu0RRTHeUFIRiRLSorGESLAUgKTECsViCSSByAgMiRVUCSqwIpICgKCxYLArMhXD
ErWCZircWFlhI1igzKpVmStYBrFTWJuyhlrDmAOPjNJIGMgITkpmZXUPG8LMAWFSwtVxiwG3
ZDcBxCu0oFiruMiWCAVJDW8BdQDcCAHIRJIGfZyhPuTm8cGusPttw+5DqvRPfKsAP3CdZN+W
sow0QIGM47ZJJC5DYUFe5THaPprkh6yKS2hLywkzg0IcQPClC+WEm/aE99p97CG/brenDGHn
z5kITTv1I8blR00zSwQZHXYFUCDNLqWY08NK14pmHAF6tWB3w5oSBEVikEkgGyRpAoVmZvMZ
rfK4TfLogKzfGzZvG0XGZcycZUS1EN2CQah/SbX0ggTk7tK2SOQAHblc9GevHTITVCoG0JUh
D1JIoBKTRhJOE3CXsPAhpy4rF13fOumRAGgVCEB4JBjCEc+irIO3IDSiICefbeRu2N1O+e0N
UgYAemBgAc5VwonbkBPDfDcpaBmEs5tPOnvHuOAE8Uk3w6dayBfCJnURuXkg1YxXJpDmUEtq
1PjPtWYI2euTtfX0TTMPEERhd2YHy4g0bhVrrfQDKCRAB156aK6O6W6gEAqkySd+ZgYqbeum
SB5reQh8d8oSpOtiCno+uQRgOxKgTBkJokWct2lVWIxv7nyeg8iomsw7nnvUXHWr5PNeOvAJ
05FYCdSsii+26QoIpEUYLBIopIJtMyySXy95T4wOM0fTMDe7Da/LNpWTXbWTSdgMgwVkYle9
uCAkRBSEVBMx5d88bnffTvO5R6k0wH4EsBoUuQlCWzb6AJz0HCDeWT3lJMti5osNIGOkVTGG
4IBqzMiMCoAenmMgFEDCoet833hvlddrbkShmUsUWUWWo1iKMYRWJMZGs4e8nC7PMrpvOekr
7mGdFhA5133UNIE0gHUDGPaPYglCHEKewVIATRAmSpJddN+8HmAbrYUVsJ9loEH0YF1dYAR7
cfkrYhOG4gOBSga2rvY1OW/fSiAqwMOyHV1hKknhmJisyOYHnxoZR8yD5AiZu8d76vvlHQKJ
R7oqyoYqYnpGbq7RaybSXuqZND1NMMZ4hLIWyu2TWimpFEMgIJEsgC5gtAAV8CMWxByZwW9u
vCBv1bo7ckkT4gwyAeQFkzlTBJRAslAogEIm9LCmahBzA6b+GBtDzyyHXiHEnqBtDrAMTrJa
NWbZkDlNIvOdhBAQQvvtUHCEDXFjrIK988t3JcEgSLn7T8QUMAREVdv7ARYPkffL6/qIASg7
8YBDnjHOUDc6xPyXP6FKdmt09Iqle+2LB6SjN7sCa9XveVtySQ9vOXB0MhBPgi3NodkCAYV8
6pzuHW1M3EQLfkZlNDOs4iEVuCuWBIFIIj0DukVrzVmdW9ID1PEmfowEBEeC3mMoRGEfbkjU
iBgLN7I+LKY7LdgOW7IRcr3veBFgkajZFqwzDxGn3tnmnStZhVhjMwgY3CAfCQCSK1hFBBXF
6wdxhEH4ovNyfVMYro7Tr2eiSYGDkGzRvPXfY0uKbuZSGTyTTNlEYl0CUxb775zMA7ouBkAZ
20iC5nl6+CifxZ+CRTGamm2rhxBbCTTcAISBTcGqGhlgjtL6NVysnV5fIzaig793qm73w9wS
aFUTXokMCBXWORqCyUPaDBUvAW4zh5VGO1VbO+JAcKOaWt7MNUkkZWpyqqEQ09UULiryNj6F
QmVmYeRKUNkEsDxN7LWnZmZMAhPV+ML/B6I2M34YjGroiOQaCUITNwktfy1AmkCUDDRa5AAk
fnoirKge9QEXtzds5OBe05mN1GYkZgLuD8Jzo2c3V87DUdhYY8JKQIW83PAyKjQifjldX0Zl
/TB33hIIu7JOR8fgAjZBCFFbOiDUFMNuqASCOwH8ylwUEszEAUE1fQr2KJGsSlckmJDJA3lk
zytboDZBaYRCASTa+zJ+pkEeIIwbJClDTt0QBJq/szqPsgQztiwIGiJtxvQCbt3H3bna5cwG
FNvp7KEieie5R33u2p5Prj0gHc8dzRNpA8iI+VZPylYAprpmgslykkFmRAQ5Qa+wD3aq0Zu1
UZ8x6vu7xIBlAG+4g1Ak18McBiWkAKCJFhGBYD3ArCJGEiJNRKO8uQdbsmMlhGqgrYQ+ZMHc
TGCMTSQmGMIvx4MkcvCe5jXsPHQpEJAwH6dByHIa0J8eblZstvfKGAGmQ8OwhMLnpBpHy3T5
bMTfmDQBxan6p99VpVoGJC8bkg3JEhoUxyobjGb+RSFW28VBdQyupRdxVP0i9Bwt+XT7LFTm
we5gMImx02KkBIiEGDReEBlM4Rp6vocRDkLTTZ5pOc5gHdN1KaNAkxAhw2vTNXWbtx6drwtw
EEtEIlxrfPCNtusefPPc8OfBkEaXGpAhzLh1OawSYtJIeGgsdAgek34XBFE6sKj7ONSwTvkh
TG11rt6KmT5WJPujzcnAECQEDYZJMBGR7X9Wjydx0kY6lvRxbIIiGD3yZl5dipIjIDEJwmzs
SIPRYWwFGRbVnAKA5VyE1bzsFXFhbjEQ5VmIGjUBCJB3FqE50KZUQ9XS8zp73ejyjyFu425d
1PTte7ydpce5iWmRJro1L2Hm0kgm2m498OAjGQN5d71PhY8IvSkBdZBDtE3B5DEfbArzpYKW
qqpFUEl6CDSIE2APPsW+LfphiQZFz3pVey4Z4BwBJowpTFzS9P0P3E2ITAHIxCQZJ+cqbHqk
UZ+HxJpkm2CgsDzzlj9Fwc7fVV+MMyw1Wqb+Igq8XSF0T/E8q8ziwbn0GUyc3re7kFiKEwAd
RY6jARXXNUMoFUQVCqOGaL8+vbAqOSctRl7MgIKjQ5flEc6e+Onhz0+nILfngHEdTvFTKiQS
QRKIIsvEfpHgAr+hQR8Jsg5AB9NXVhoBixsQkRkgi1S6vJ5bA2cFoA4vD1Xd8JVEXiiBT4qE
3ufjdVC5EAZp9ltpWOm+/XhDQ6cV1mjqGuvzz489LLKK8xrdkB8BGxHz+AHGyAiLYQlms1ho
kJFebWXi9yaDChMCBsZ6uxCRm5XTHk+rNhd1TPsy3jGIi+HpIAuKB+mPkJIARZJJFBUZHnee
97+eQYmc3t4i8fG8QsJMPIcRTLIUAikJO791Cd2Sb9HZkGNvahmEUABT8ohEkS4qx5JwurFI
wEeF5Aj31tCflFsF9QmHckABqq2B0U71Ahn0TsD28yhm5A5813RD/0J+UJYT6pMk7J7p6psn
mnsnonynsn0nunVOyd6dE/ydU3SfKck+kxOab0xOCfhOSeCeKcU5Jid6flPBNk6Jib5OyeKa
k+E6J3JzTaTdJzTJP+LuSKcKEhhBvSHA
--------------045F1643A1F0FCCCBC8416DE--

